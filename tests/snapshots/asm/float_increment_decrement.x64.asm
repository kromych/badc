
float_increment_decrement.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x3f800000, -0x8(%rbp) # imm = 0x3F800000
               	movss	-0x8(%rbp), %xmm1
               	vcvtss2sd	%xmm1, %xmm1, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	<rip>, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	vaddsd	<rip>, %xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movss	-0x10(%rbp), %xmm1
               	movss	<rip>, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	vaddsd	<rip>, %xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
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
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	-0x8(%rbp), %xmm2
               	vaddsd	<rip>, %xmm2, %xmm2
               	movsd	%xmm2, -0x8(%rbp)
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm0
               	jp	<addr>
               	jne	<addr>
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
