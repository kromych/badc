
runtime_range_designator.x64:	file format elf64-x86-64

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
               	subq	$0x58, %rsp
               	movl	$0x1, <rip> # <addr>
               	movl	$0xb, 0x8(%rsp)
               	movl	$0xb, 0xc(%rsp)
               	movabsq	$0xb0000000b, %rcx      # imm = 0xB0000000B
               	movq	%rcx, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	%rcx, 0x20(%rsp)
               	movl	$0xb, 0x28(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	%eax, 0x2c(%rsp)
               	movl	%eax, 0x30(%rsp)
               	movl	%eax, 0x34(%rsp)
               	movl	%eax, 0x38(%rsp)
               	movl	%eax, 0x3c(%rsp)
               	movl	%eax, 0x40(%rsp)
               	movl	%eax, 0x44(%rsp)
               	movl	%eax, 0x48(%rsp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movss	<rip>, %xmm0
               	movss	%xmm0, 0x40(%rsp)
               	movl	0x40(%rsp), %eax
               	movl	%eax, 0x48(%rsp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	movl	$0x1, <rip> # <addr>
               	movl	$0x13, 0x8(%rsp)
               	movl	$0x13, 0xc(%rsp)
               	movabsq	$0x1300000013, %rcx     # imm = 0x1300000013
               	movq	%rcx, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	%rcx, 0x20(%rsp)
               	movl	$0x13, 0x28(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	%eax, 0x2c(%rsp)
               	movl	%eax, 0x30(%rsp)
               	movl	%eax, 0x34(%rsp)
               	movl	%eax, 0x38(%rsp)
               	movl	%eax, 0x3c(%rsp)
               	movl	%eax, 0x40(%rsp)
               	movl	%eax, 0x44(%rsp)
               	movl	%eax, 0x48(%rsp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x69, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	movl	0x8(%rsp,%rax,4), %edx
               	cmpl	$0x13, %edx
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x11, %eax
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	movss	0x40(%rsp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	0x48(%rsp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	movl	0x8(%rsp,%rax,4), %edx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x11, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
