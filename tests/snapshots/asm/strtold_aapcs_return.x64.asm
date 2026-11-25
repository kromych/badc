
strtold_aapcs_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x48, %rsp
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	fstpt	0x10(%rsp)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rsp)
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	fstpt	0x10(%rsp)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	fstpt	0x10(%rsp)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rsi
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x20(%rsp), %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	testl	%eax, %eax
               	jg	<addr>
               	movl	$0x4, %eax
               	addq	$0x48, %rsp
               	retq
               	movsbq	0x20(%rsp), %rax
               	cmpl	$0x34, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
