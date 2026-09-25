
long_double_libc_return.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	fstpt	-0x10(%rbp)
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x45f0000000000000, %rax # imm = 0x45F0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	fstpt	-0x10(%rbp)
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x43f0000000000000, %rax # imm = 0x43F0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movl	$0x35, %edi
               	leaq	-0x20(%rbp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%r9)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x10, %rsp
               	fstpt	-0x10(%rbp)
               	fldt	-0x10(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4340000000000000, %rax # imm = 0x4340000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
