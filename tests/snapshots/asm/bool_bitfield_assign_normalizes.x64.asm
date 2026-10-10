
bool_bitfield_assign_normalizes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x0, (%rax)
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x2, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x1, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x1, -0x8(%rbp)
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x1, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x2, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	xorl	%ecx, %ecx
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	andq	$0x1, %rax
               	shlq	%rax
               	orq	$0x1, %rax
               	movb	%al, -0x8(%rbp)
               	sarq	%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	cvttsd2si	%xmm14, %rax
               	andq	$0x7, %rax
               	movl	-0x8(%rbp), %edx
               	andq	$-0x1d, %rdx
               	shlq	$0x2, %rax
               	orq	%rdx, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %edx
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	xorq	$0x2, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm14
               	cvttsd2si	%xmm14, %rdx
               	andq	$0xf, %rdx
               	andq	$-0x1e1, %rax           # imm = 0xFE1F
               	shlq	$0x5, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %edx
               	sarq	$0x5, %rdx
               	andq	$0xf, %rdx
               	shlq	$0x3c, %rdx
               	sarq	$0x3c, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	andq	$-0x1d, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %edx
               	sarq	$0x2, %rdx
               	testb	$0x7, %dl
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdx
               	andq	$-0x1d, %rax
               	orq	$0x4, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %esi
               	sarq	$0x2, %rsi
               	andq	$0x7, %rsi
               	xorq	$0x1, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	andq	$-0x1e1, %rax           # imm = 0xFE1F
               	orq	$0x120, %rax            # imm = 0x120
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %eax
               	sarq	$0x5, %rax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movzbq	(%rax), %rsi
               	sarq	%rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	(%rax), %esi
               	sarq	$0x2, %rsi
               	andq	$0x7, %rsi
               	xorq	$0x1, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	(%rax), %eax
               	sarq	$0x5, %rax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rsi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	cmpb	$0x0, 0x1(%rax)
               	jne	<addr>
               	movzbq	0x2(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	cmpb	$0x0, 0x1(%rax)
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movzbq	0x2(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movzbq	(%rax), %rax
               	sarq	%rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	movl	$0x0, (%rdx)
               	movb	%cl, -0x8(%rbp)
               	movb	$0x2, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	andq	$-0x1d, %rcx
               	movl	%ecx, -0x8(%rbp)
               	andq	$-0x1e1, %rcx           # imm = 0xFE1F
               	movl	%ecx, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movb	$0x2, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	andq	$-0x3, %rax
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	sarq	%rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x26, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
