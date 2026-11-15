
runtime_range_designator.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movl	$0x1, <rip> # <addr>
               	movl	$0xb, -0x48(%rbp)
               	movl	$0xb, -0x44(%rbp)
               	movabsq	$0xb0000000b, %rcx      # imm = 0xB0000000B
               	movq	%rcx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movl	$0xb, -0x28(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x24(%rbp)
               	movl	%eax, -0x20(%rbp)
               	movl	%eax, -0x1c(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movl	%eax, -0x14(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0xc(%rbp)
               	movl	%eax, -0x8(%rbp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movss	<rip>, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	movl	%eax, -0x8(%rbp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	$0x1, <rip> # <addr>
               	movl	$0x13, -0x48(%rbp)
               	movl	$0x13, -0x44(%rbp)
               	movabsq	$0x1300000013, %rcx     # imm = 0x1300000013
               	movq	%rcx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movl	$0x13, -0x28(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x24(%rbp)
               	movl	%eax, -0x20(%rbp)
               	movl	%eax, -0x1c(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movl	%eax, -0x14(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0xc(%rbp)
               	movl	%eax, -0x8(%rbp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x69, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	-0x48(%rbp,%rax,4), %edx
               	cmpl	$0x13, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	movss	-0x10(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0x8(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	movl	-0x48(%rbp,%rax,4), %edx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
