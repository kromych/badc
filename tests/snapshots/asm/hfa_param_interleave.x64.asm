
hfa_param_interleave.x64:	file format elf64-x86-64

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
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	$0x41180000, %eax       # imm = 0x41180000
               	movss	-0x20(%rbp), %xmm0
               	movss	-0x1c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x18(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x8(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x4(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	vaddss	%xmm15, %xmm0, %xmm1
               	movl	$0xa, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	addss	%xmm0, %xmm1
               	movl	$0x425e0000, %eax       # imm = 0x425E0000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	$0x3e800000, %ecx       # imm = 0x3E800000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	vaddss	%xmm15, %xmm14, %xmm1
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm1
               	movq	%rcx, %xmm15
               	addss	%xmm15, %xmm1
               	vaddss	%xmm0, %xmm1, %xmm0
               	movl	$0x41240000, %eax       # imm = 0x41240000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
