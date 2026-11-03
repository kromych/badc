
c11_atomic_specifier.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movb	$-0x38, -0x38(%rbp)
               	movw	$0x9c40, -0x28(%rbp)    # imm = 0x9C40
               	movl	$0x11223344, -0x20(%rbp) # imm = 0x11223344
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0xc8, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	xorq	$0x9c40, %rcx           # imm = 0x9C40
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movl	(%rcx), %ecx
               	cmpl	$0x11223344, %ecx       # imm = 0x11223344
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0xc8, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0xfa, %ecx
               	movq	%rcx, %r10
               	xchgb	%r10b, (%rax)
               	movzbq	(%rax), %rax
               	xorq	$0xfa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0xfffffff9, -0x30(%rbp) # imm = 0xFFFFFFF9
               	movq	$0x63, -0x10(%rbp)
               	movw	$0xd, -0x8(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %ecx
               	cmpl	$-0x7, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xd, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x15, %ecx
               	movq	%rcx, %r10
               	xchgl	%r10d, (%rax)
               	movl	(%rax), %eax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
