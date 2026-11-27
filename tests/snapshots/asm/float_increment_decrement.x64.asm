
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
               	subq	$0x28, %rsp
               	movl	$0x3f800000, 0x18(%rsp) # imm = 0x3F800000
               	movss	0x18(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, 0x18(%rsp)
               	movss	0x18(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, 0x18(%rsp)
               	movss	0x18(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	<rip>, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, 0x10(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, 0x18(%rsp)
               	movss	0x10(%rsp), %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	vaddsd	<rip>, %xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movsd	<rip>, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	0x18(%rsp), %xmm1
               	vaddsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x18(%rsp)
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
