
const_time_des_round_wide_imm.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<des_round>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	%edi, %eax
               	movq	%rax, %rcx
               	andq	$0x11111111, %rcx       # imm = 0x11111111
               	movq	%rax, %rdx
               	shrq	%rdx
               	andq	$0x11111111, %rdx       # imm = 0x11111111
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	andq	$0x11111111, %rdi       # imm = 0x11111111
               	shrq	$0x3, %rax
               	movq	%rax, %r8
               	andq	$0x11111111, %r8        # imm = 0x11111111
               	movl	%ecx, %eax
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movl	%ecx, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movl	%eax, %ecx
               	movl	%edx, %eax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	movl	%edx, %edx
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movl	%eax, %edx
               	movl	%edi, %eax
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	movl	%edi, %edi
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	subq	%r10, %rax
               	movl	%eax, %edi
               	movl	%r8d, %eax
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	movl	%r8d, %r8d
               	movq	%rax, %r10
               	movq	%r8, %rax
               	subq	%r10, %rax
               	movl	%eax, %eax
               	movl	%eax, %r8d
               	movq	%r8, %rax
               	shlq	$0x4, %rax
               	movl	%eax, %eax
               	movq	%r8, %r9
               	shrq	$0x1c, %r9
               	orq	%r9, %rax
               	movl	%ecx, %ecx
               	movq	%rcx, %r9
               	shrq	$0x4, %r9
               	movq	%rcx, %rbx
               	shlq	$0x1c, %rbx
               	movl	%ebx, %ebx
               	orq	%rbx, %r9
               	movl	%eax, %eax
               	movl	(%rsi), %ebx
               	xorq	%rbx, %rax
               	movl	%eax, %eax
               	movl	0x4(%rsi), %ebx
               	xorq	%rbx, %rcx
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	0x8(%rsi), %ebx
               	xorq	%rbx, %rdx
               	movl	%edx, %edx
               	movl	%edi, %edi
               	movl	0xc(%rsi), %ebx
               	xorq	%rbx, %rdi
               	movl	%edi, %edi
               	movl	0x10(%rsi), %ebx
               	xorq	%rbx, %r8
               	movl	%r8d, %r8d
               	movl	%r9d, %r9d
               	movl	0x14(%rsi), %esi
               	xorq	%r9, %rsi
               	movl	%esi, %r10d
               	movq	%r10, 0x38(%rsp)
               	movl	$0xec7ac69c, %esi       # imm = 0xEC7AC69C
               	andq	%rax, %rsi
               	movl	$0xefa72c4d, %r11d      # imm = 0xEFA72C4D
               	xorq	%r11, %rsi
               	movq	%rax, %r9
               	andq	$0x500fb821, %r9        # imm = 0x500FB821
               	movl	$0xaeaaedff, %r11d      # imm = 0xAEAAEDFF
               	xorq	%r11, %r9
               	movq	%rax, %rbx
               	andq	$0x40efa809, %rbx       # imm = 0x40EFA809
               	xorq	$0x37396665, %rbx       # imm = 0x37396665
               	movl	$0xa5ec0b28, %r12d      # imm = 0xA5EC0B28
               	andq	%rax, %r12
               	xorq	$0x68d7b833, %r12       # imm = 0x68D7B833
               	movq	%rax, %r13
               	andq	$0x252cf820, %r13       # imm = 0x252CF820
               	movl	$0xc9c755bb, %r11d      # imm = 0xC9C755BB
               	xorq	%r11, %r13
               	movq	%rax, %r14
               	andq	$0x40205801, %r14       # imm = 0x40205801
               	xorq	$0x73fc3606, %r14       # imm = 0x73FC3606
               	movl	$0xe220f929, %r15d      # imm = 0xE220F929
               	andq	%rax, %r15
               	movl	$0xa2a0a918, %r11d      # imm = 0xA2A0A918
               	xorq	%r11, %r15
               	movq	%rax, %r10
               	andq	$0x44a3f9e1, %r10       # imm = 0x44A3F9E1
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe8(%rsp), %r10
               	movl	$0x8222bd90, %r11d      # imm = 0x8222BD90
               	xorq	%r11, %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	%rax, %r10
               	andq	$0x794f104a, %r10       # imm = 0x794F104A
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe0(%rsp), %r10
               	movl	$0xd6b6ac77, %r11d      # imm = 0xD6B6AC77
               	xorq	%r11, %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	%rax, %r10
               	andq	$0x26f320b, %r10        # imm = 0x26F320B
               	movq	%r10, 0xd8(%rsp)
               	movq	0xd8(%rsp), %r10
               	xorq	$0x3069300c, %r10       # imm = 0x3069300C
               	movq	%r10, 0xd8(%rsp)
               	movq	%rax, %r10
               	andq	$0x7640b01a, %r10       # imm = 0x7640B01A
               	movq	%r10, 0xd0(%rsp)
               	movq	0xd0(%rsp), %r10
               	xorq	$0x6ce0d5cc, %r10       # imm = 0x6CE0D5CC
               	movq	%r10, 0xd0(%rsp)
               	movq	%rax, %r10
               	andq	$0x238f1572, %r10       # imm = 0x238F1572
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %r10
               	xorq	$0x59a9a22d, %r10       # imm = 0x59A9A22D
               	movq	%r10, 0xc8(%rsp)
               	movq	%rax, %r10
               	andq	$0x7a63c083, %r10       # imm = 0x7A63C083
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r10
               	movl	$0xac6d0bd4, %r11d      # imm = 0xAC6D0BD4
               	xorq	%r11, %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	%rax, %r10
               	andq	$0x11cca000, %r10       # imm = 0x11CCA000
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r10
               	xorq	$0x21c83200, %r10       # imm = 0x21C83200
               	movq	%r10, 0xb8(%rsp)
               	movq	%rax, %r10
               	andq	$0x202f69aa, %r10       # imm = 0x202F69AA
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r10
               	movl	$0xa0e62188, %r11d      # imm = 0xA0E62188
               	xorq	%r11, %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	%rax, %r10
               	andq	$0x51b33be9, %r10       # imm = 0x51B33BE9
               	movq	%r10, 0xa8(%rsp)
               	movq	0xa8(%rsp), %r10
               	movl	$0xaf7d655a, %r11d      # imm = 0xAF7D655A
               	xorq	%r11, %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	%rax, %r10
               	andq	$0x3b0fe8ae, %r10       # imm = 0x3B0FE8AE
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r10
               	movl	$0xf0168aa3, %r11d      # imm = 0xF0168AA3
               	xorq	%r11, %r10
               	movq	%r10, 0xa0(%rsp)
               	movl	$0x90bf8816, %r10d      # imm = 0x90BF8816
               	andq	%rax, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x98(%rsp), %r10
               	movl	$0x90aa30c6, %r11d      # imm = 0x90AA30C6
               	xorq	%r11, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	%rax, %r10
               	andq	$0x9e34f9b, %r10        # imm = 0x9E34F9B
               	movq	%r10, 0x90(%rsp)
               	movq	0x90(%rsp), %r10
               	xorq	$0x5ab2750a, %r10       # imm = 0x5AB2750A
               	movq	%r10, 0x90(%rsp)
               	movq	%rax, %r10
               	andq	$0x103be88, %r10        # imm = 0x103BE88
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %r10
               	xorq	$0x5391be65, %r10       # imm = 0x5391BE65
               	movq	%r10, 0x88(%rsp)
               	movq	%rax, %r10
               	andq	$0x49ac8e25, %r10       # imm = 0x49AC8E25
               	movq	%r10, 0x80(%rsp)
               	movq	0x80(%rsp), %r10
               	movl	$0x93372baf, %r11d      # imm = 0x93372BAF
               	xorq	%r11, %r10
               	movq	%r10, 0x80(%rsp)
               	movl	$0x922c313d, %r10d      # imm = 0x922C313D
               	andq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %r10
               	movl	$0xf288210c, %r11d      # imm = 0xF288210C
               	xorq	%r11, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%rax, %r10
               	andq	$0x70ef31b0, %r10       # imm = 0x70EF31B0
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %r10
               	movl	$0x920af5c0, %r11d      # imm = 0x920AF5C0
               	xorq	%r11, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	%rax, %r10
               	andq	$0x6a707100, %r10       # imm = 0x6A707100
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %r10
               	xorq	$0x63d312c0, %r10       # imm = 0x63D312C0
               	movq	%r10, 0x68(%rsp)
               	movl	$0xb97c9011, %r10d      # imm = 0xB97C9011
               	andq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	xorq	$0x537b3006, %r10       # imm = 0x537B3006
               	movq	%r10, 0x60(%rsp)
               	movl	$0xa320c959, %r10d      # imm = 0xA320C959
               	andq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	$0xa2efb0a5, %r11d      # imm = 0xA2EFB0A5
               	xorq	%r11, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rax, %r10
               	andq	$0x6ea0ab4a, %r10       # imm = 0x6EA0AB4A
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movl	$0xbc8f96a5, %r11d      # imm = 0xBC8F96A5
               	xorq	%r11, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rax, %r10
               	andq	$0x6953ddf8, %r10       # imm = 0x6953DDF8
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	movl	$0xfad176a5, %r11d      # imm = 0xFAD176A5
               	xorq	%r11, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0xf74f3e2b, %r10d      # imm = 0xF74F3E2B
               	andq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	xorq	$0x665a14a3, %r10       # imm = 0x665A14A3
               	movq	%r10, 0x40(%rsp)
               	movl	$0xf0306cad, %r11d      # imm = 0xF0306CAD
               	andq	%r11, %rax
               	movl	$0xf2eff0cc, %r11d      # imm = 0xF2EFF0CC
               	xorq	%r11, %rax
               	movl	%esi, %esi
               	movl	%r9d, %r9d
               	andq	%rcx, %r9
               	xorq	%r9, %rsi
               	movl	%ebx, %r9d
               	movl	%r12d, %ebx
               	andq	%rcx, %rbx
               	xorq	%rbx, %r9
               	movl	%r13d, %ebx
               	movl	%r14d, %r12d
               	andq	%rcx, %r12
               	xorq	%r12, %rbx
               	movl	%r15d, %r12d
               	movq	0xe8(%rsp), %r13
               	movl	%r13d, %r13d
               	andq	%rcx, %r13
               	xorq	%r13, %r12
               	movq	0xe0(%rsp), %r13
               	movl	%r13d, %r13d
               	movq	0xd8(%rsp), %r14
               	movl	%r14d, %r14d
               	andq	%rcx, %r14
               	xorq	%r14, %r13
               	movq	0xd0(%rsp), %r14
               	movl	%r14d, %r14d
               	movq	0xc8(%rsp), %r15
               	movl	%r15d, %r15d
               	andq	%rcx, %r15
               	xorq	%r15, %r14
               	movq	0xc0(%rsp), %r15
               	movl	%r15d, %r15d
               	movq	0xb8(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xe8(%rsp)
               	movq	%rcx, %r10
               	andq	0xe8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	xorq	0xe8(%rsp), %r15
               	movq	0xb0(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xb8(%rsp)
               	movq	0xa8(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xe8(%rsp)
               	movq	0xa0(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xe0(%rsp)
               	movq	%rcx, %r10
               	andq	0xe0(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %r10
               	xorq	0xe0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0x98(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xe0(%rsp)
               	movq	0x90(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xd8(%rsp)
               	movq	%rcx, %r10
               	andq	0xd8(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xe0(%rsp), %r10
               	xorq	0xd8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0x88(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xd8(%rsp)
               	movq	0x80(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xd0(%rsp)
               	movq	%rcx, %r10
               	andq	0xd0(%rsp), %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	0xd8(%rsp), %r10
               	xorq	0xd0(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0x78(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xd0(%rsp)
               	movq	0x70(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xc8(%rsp)
               	movq	%rcx, %r10
               	andq	0xc8(%rsp), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xd0(%rsp), %r10
               	xorq	0xc8(%rsp), %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	0x68(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xc8(%rsp)
               	movq	0x60(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	%rcx, %r10
               	andq	0xc0(%rsp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc8(%rsp), %r10
               	xorq	0xc0(%rsp), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0x50(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	%rcx, %r10
               	andq	0xb0(%rsp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0xc0(%rsp), %r10
               	xorq	0xb0(%rsp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	0x48(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0x40(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xa8(%rsp)
               	andq	0xa8(%rsp), %rcx
               	movq	%rcx, %r10
               	movq	0xb0(%rsp), %rcx
               	xorq	%r10, %rcx
               	movl	%eax, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movl	%esi, %eax
               	movl	%r9d, %esi
               	andq	%rdx, %rsi
               	xorq	%rsi, %rax
               	movl	%ebx, %esi
               	movl	%r12d, %r9d
               	andq	%rdx, %r9
               	xorq	%r9, %rsi
               	movl	%r13d, %r9d
               	movl	%r14d, %ebx
               	andq	%rdx, %rbx
               	xorq	%rbx, %r9
               	movl	%r15d, %ebx
               	movq	0xb8(%rsp), %r12
               	movl	%r12d, %r12d
               	andq	%rdx, %r12
               	xorq	%r12, %rbx
               	movq	0xe8(%rsp), %r12
               	movl	%r12d, %r12d
               	movq	0xe0(%rsp), %r13
               	movl	%r13d, %r13d
               	andq	%rdx, %r13
               	xorq	%r13, %r12
               	movq	0xd8(%rsp), %r13
               	movl	%r13d, %r13d
               	movq	0xd0(%rsp), %r14
               	movl	%r14d, %r14d
               	andq	%rdx, %r14
               	xorq	%r14, %r13
               	movq	0xc8(%rsp), %r14
               	movl	%r14d, %r14d
               	movq	0xc0(%rsp), %r15
               	movl	%r15d, %r15d
               	andq	%rdx, %r15
               	xorq	%r15, %r14
               	movl	%ecx, %ecx
               	movq	0xb0(%rsp), %r15
               	movl	%r15d, %r15d
               	andq	%r15, %rdx
               	xorq	%rdx, %rcx
               	movl	%eax, %eax
               	movl	%esi, %edx
               	andq	%rdi, %rdx
               	xorq	%rdx, %rax
               	movl	%r9d, %edx
               	movl	%ebx, %esi
               	andq	%rdi, %rsi
               	xorq	%rsi, %rdx
               	movl	%r12d, %esi
               	movl	%r13d, %r9d
               	andq	%rdi, %r9
               	xorq	%r9, %rsi
               	movl	%r14d, %r9d
               	movl	%ecx, %ecx
               	andq	%rdi, %rcx
               	xorq	%r9, %rcx
               	movl	%eax, %eax
               	movl	%edx, %edx
               	andq	%r8, %rdx
               	xorq	%rdx, %rax
               	movl	%esi, %edx
               	movl	%ecx, %ecx
               	andq	%r8, %rcx
               	xorq	%rdx, %rcx
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	movq	%rcx, %r10
               	movq	0x38(%rsp), %rcx
               	andq	%r10, %rcx
               	xorq	%rcx, %rax
               	movl	%eax, %ecx
               	movq	%rcx, %rdx
               	andq	$0x4, %rdx
               	shlq	$0x3, %rdx
               	movl	%edx, %edx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x4000, %rsi           # imm = 0x4000
               	shlq	$0x4, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	andq	$0x12020120, %rcx       # imm = 0x12020120
               	movl	%ecx, %ecx
               	movq	%rcx, %rsi
               	shlq	$0x5, %rsi
               	movl	%esi, %esi
               	shrq	$0x1b, %rcx
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	orq	%rdx, %rcx
               	movl	%ecx, %edx
               	movl	%eax, %ecx
               	movq	%rcx, %rsi
               	andq	$0x100000, %rsi         # imm = 0x100000
               	shlq	$0x6, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x8000, %rsi           # imm = 0x8000
               	shlq	$0x9, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x4000000, %rsi        # imm = 0x4000000
               	shrq	$0x16, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x1, %rsi
               	shlq	$0xb, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	andq	$0x20000200, %rcx       # imm = 0x20000200
               	movl	%ecx, %ecx
               	movq	%rcx, %rsi
               	shlq	$0xc, %rsi
               	movl	%esi, %esi
               	shrq	$0x14, %rcx
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	orq	%rdx, %rcx
               	movl	%ecx, %edx
               	movl	%eax, %ecx
               	movq	%rcx, %rsi
               	andq	$0x200000, %rsi         # imm = 0x200000
               	shrq	$0x13, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x40, %rsi
               	shlq	$0xe, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x10000, %rsi          # imm = 0x10000
               	shlq	$0xf, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x2, %rsi
               	shlq	$0x10, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	andq	$0x40801800, %rcx       # imm = 0x40801800
               	movl	%ecx, %ecx
               	movq	%rcx, %rsi
               	shlq	$0x11, %rsi
               	movl	%esi, %esi
               	shrq	$0xf, %rcx
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	orq	%rdx, %rcx
               	movl	%ecx, %edx
               	movl	%eax, %ecx
               	movq	%rcx, %rsi
               	andq	$0x80000, %rsi          # imm = 0x80000
               	shrq	$0xd, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x10, %rsi
               	shlq	$0x15, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x1000000, %rsi        # imm = 0x1000000
               	shrq	$0xa, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	movl	$0x88000008, %r11d      # imm = 0x88000008
               	andq	%r11, %rcx
               	movl	%ecx, %ecx
               	movq	%rcx, %rsi
               	shlq	$0x18, %rsi
               	movl	%esi, %esi
               	shrq	$0x8, %rcx
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	%eax, %eax
               	movq	%rax, %rdx
               	andq	$0x480, %rdx            # imm = 0x480
               	shrq	$0x7, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	andq	$0x442000, %rax         # imm = 0x442000
               	shrq	$0x6, %rax
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa5a5a5a5, %edi       # imm = 0xA5A5A5A5
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	$0x0, %rax
               	movl	%eax, %ebx
               	movl	$0xd2f51ac0, %edi       # imm = 0xD2F51AC0
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0x3849cf1f, %edi       # imm = 0x3849CF1F
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0xbabbd1f2, %edi       # imm = 0xBABBD1F2
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0xe4108a9, %edi        # imm = 0xE4108A9
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0xb7b0b9f4, %edi       # imm = 0xB7B0B9F4
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0x23539cc3, %edi       # imm = 0x23539CC3
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0xa72e9b46, %edi       # imm = 0xA72E9B46
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0x7580b9ed, %edi       # imm = 0x7580B9ED
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0xa631d268, %edi       # imm = 0xA631D268
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0x12f412a7, %edi       # imm = 0x12F412A7
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0x44916fda, %edi       # imm = 0x44916FDA
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0x96ac7d71, %edi       # imm = 0x96AC7D71
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0xdd35581c, %edi       # imm = 0xDD35581C
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0x53fb94cb, %edi       # imm = 0x53FB94CB
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ebx
               	movl	$0x455163ae, %edi       # imm = 0x455163AE
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	xorq	%rax, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	xorq	%rdx, %rcx
               	shrq	$0x18, %rax
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
