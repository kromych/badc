
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
               	subq	$0x70, %rsp
               	movl	$0x0, <rip> # <addr>
               	leaq	-0x48(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movl	$0x0, 0x40(%rax)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0xb, -0x48(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x44(%rbp)
               	movl	%eax, -0x40(%rbp)
               	movl	%eax, -0x3c(%rbp)
               	movl	%eax, -0x38(%rbp)
               	movl	%eax, -0x34(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x30(%rbp)
               	movl	%eax, -0x2c(%rbp)
               	movl	%eax, -0x28(%rbp)
               	movl	%eax, -0x24(%rbp)
               	movl	%eax, -0x20(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x1c(%rbp)
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	movl	%eax, -0x14(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0xc(%rbp)
               	movl	-0x48(%rbp), %eax
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
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x66, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	$0x0, -0x48(%rbp)
               	movq	$0x0, -0x40(%rbp)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x48(%rbp)
               	movq	-0x48(%rbp), %rcx
               	movq	%rcx, -0x40(%rbp)
               	leaq	-0x68(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	movl	$0x0, 0x8(%rcx)
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	$0x40400000, -0x68(%rbp) # imm = 0x40400000
               	movl	-0x68(%rbp), %ecx
               	movl	%ecx, -0x60(%rbp)
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x67, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	leaq	-0x48(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movl	$0x0, 0x40(%rax)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x13, -0x48(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x44(%rbp)
               	movl	%eax, -0x40(%rbp)
               	movl	%eax, -0x3c(%rbp)
               	movl	%eax, -0x38(%rbp)
               	movl	%eax, -0x34(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x30(%rbp)
               	movl	%eax, -0x2c(%rbp)
               	movl	%eax, -0x28(%rbp)
               	movl	%eax, -0x24(%rbp)
               	movl	%eax, -0x20(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x1c(%rbp)
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	movl	%eax, -0x14(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0xc(%rbp)
               	movl	-0x48(%rbp), %eax
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
               	movl	(%rcx,%rax,4), %edx
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
               	movsd	-0x48(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x40(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x68(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x60(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %edx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
