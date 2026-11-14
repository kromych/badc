
float_increment_decrement.x64:	file format elf64-x86-64

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
               	movl	$0x3f800000, -0x8(%rbp) # imm = 0x3F800000
               	movss	-0x8(%rbp), %xmm1
               	movsd	<rip>, %xmm0
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm0, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm0, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm1
               	movss	<rip>, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x10(%rbp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm0, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	movsd	-0x8(%rbp), %xmm2
               	movsd	<rip>, %xmm1
               	addsd	%xmm1, %xmm2
               	movsd	%xmm2, -0x8(%rbp)
               	movss	-0x10(%rbp), %xmm3
               	movss	<rip>, %xmm4
               	ucomiss	%xmm4, %xmm3
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm2 # <addr>
               	addsd	%xmm0, %xmm2
               	vaddsd	%xmm0, %xmm2, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	<rip>, %xmm0
               	addsd	%xmm0, %xmm2
               	movsd	%xmm2, -0x10(%rbp)
               	movsd	-0x8(%rbp), %xmm3
               	vaddsd	%xmm1, %xmm3, %xmm1
               	movsd	%xmm1, -0x8(%rbp)
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	jne	<addr>
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
