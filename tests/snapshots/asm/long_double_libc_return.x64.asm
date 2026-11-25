
long_double_libc_return.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	fstpt	0x10(%rsp)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	fstpt	0x10(%rsp)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	leaq	0x20(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movl	$0x35, %edi
               	callq	<addr>
               	fstpt	0x10(%rsp)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	addq	$0x28, %rsp
               	retq
