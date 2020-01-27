local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your religion?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> religion?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local englandDescription = 'Including Church of England, Catholic, Protestant and all other Christian denominations';
local walesDescription = 'All denominations';

local question(title, region_code) = (
  local optionDescription = if region_code == 'GB-WLS' then walesDescription else englandDescription;
  {
    id: 'religion-question',
    title: title,
    guidance: {
      contents: [
        {
          description: 'This question is <strong>voluntary</strong>',
        },
      ],
    },
    type: 'General',
    answers: [
      {
        id: 'religion-answer',
        mandatory: false,
        label: '',
        voluntary: true,
        options: [
          {
            label: 'No religion',
            value: 'No religion',
          },
          {
            label: 'Christian',
            value: 'Christian',
            description: optionDescription,
          },
          {
            label: 'Buddhist',
            value: 'Buddhist',
          },
          {
            label: 'Hindu',
            value: 'Hindu',
          },
          {
            label: 'Jewish',
            value: 'Jewish',
          },
          {
            label: 'Muslim',
            value: 'Muslim',
          },
          {
            label: 'Sikh',
            value: 'Sikh',
          },
          {
            label: 'Any other religion',
            value: 'Any other religion',
            description: 'Select to enter answer',
            detail_answer: {
              id: 'religion-answer-other',
              type: 'TextField',
              mandatory: false,
              label: 'Enter religion',
            },
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'religion',
  question_variants: [
    {
      question: question(nonProxyTitle, region_code),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, region_code),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'passports',
        when: [
          rules.under1,
        ],
      },
    },
    {
      goto: {
        block: 'past-usual-household-address',
      },
    },
  ],
}
