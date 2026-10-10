
anon_bitfield_reserves_bits.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movzbq	-0x6(%rbp), %rax
               	andq	$-0x5, %rax
               	orq	$0x4, %rax
               	movb	%al, -0x6(%rbp)
               	cmpb	$0x0, -0x8(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x7(%rbp)
               	jne	<addr>
               	movzbq	-0x6(%rbp), %rax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x5(%rbp)
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movzbq	-0x6(%rbp), %rax
               	andq	$-0xf9, %rax
               	orq	$0xf8, %rax
               	movb	%al, -0x6(%rbp)
               	cmpb	$0x0, -0x8(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x7(%rbp)
               	jne	<addr>
               	movzbq	-0x6(%rbp), %rax
               	xorq	$0xf8, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x5(%rbp)
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movzbq	-0x5(%rbp), %rax
               	andq	$-0x80, %rax
               	orq	$0x7f, %rax
               	movb	%al, -0x5(%rbp)
               	cmpb	$0x0, -0x8(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x7(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x6(%rbp)
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	xorq	$0x7f, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	-0x6(%rbp), %rax
               	andq	$-0x5, %rax
               	orq	$0x4, %rax
               	movb	%al, -0x6(%rbp)
               	movzbq	-0x6(%rbp), %rax
               	andq	$-0xf9, %rax
               	orq	$0x48, %rax
               	movb	%al, -0x6(%rbp)
               	movzbq	-0x5(%rbp), %rax
               	andq	$-0x80, %rax
               	orq	$0x64, %rax
               	movb	%al, -0x5(%rbp)
               	movzbq	-0x6(%rbp), %rax
               	sarq	$0x2, %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	-0x6(%rbp), %rax
               	sarq	$0x3, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	andq	$0x7f, %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movb	$-0x1, -0x5(%rbp)
               	cmpb	$0x0, -0x8(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x7(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x6(%rbp)
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, (%rax)
               	movl	$0x11223344, -0x8(%rbp) # imm = 0x11223344
               	movl	$0x55667788, -0x4(%rbp) # imm = 0x55667788
               	movl	(%rax), %ecx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %ecx
               	xorq	$0x11223344, %rcx       # imm = 0x11223344
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x4(%rbp), %ecx
               	xorq	$0x55667788, %rcx       # imm = 0x55667788
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	addq	$0x8, %rax
               	leaq	-0x10(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
