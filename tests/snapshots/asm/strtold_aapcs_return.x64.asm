
strtold_aapcs_return.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	subq	$0x10, %rsp
               	fstpl	(%rsp)
               	movq	(%rsp), %r10
               	addq	$0x10, %rsp
               	movq	%r10, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x80(%rbp)
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	subq	$0x10, %rsp
               	fstpl	(%rsp)
               	movq	(%rsp), %r10
               	addq	$0x10, %rsp
               	movq	%r10, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x70(%rbp)
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x41f0000000000000, %rax # imm = 0x41F0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x43f0000000000000, %rax # imm = 0x43F0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	subq	$0x10, %rsp
               	fstpl	(%rsp)
               	movq	(%rsp), %r10
               	addq	$0x10, %rsp
               	movq	%r10, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	fldt	-0x60(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x3f70000000000000, %rax # imm = 0xC090000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	testl	%eax, %eax
               	jg	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x34, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
