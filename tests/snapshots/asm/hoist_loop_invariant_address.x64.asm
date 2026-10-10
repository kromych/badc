
hoist_loop_invariant_address.x64:	file format elf64-x86-64

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

<setup>:
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x1, 0x4(%rax)
               	movl	$0x4, 0x8(%rax)
               	movl	$0x9, 0xc(%rax)
               	movl	$0x10, 0x10(%rax)
               	movl	$0x19, 0x14(%rax)
               	movl	$0x24, 0x18(%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x31, 0x1c(%rax)
               	movl	$0x40, 0x20(%rax)
               	movl	$0x51, 0x24(%rax)
               	leaq	<rip>, %rax      # <addr>
               	movq	$0x0, (%rax)
               	movq	$0x3b9aca07, 0x8(%rax)  # imm = 0x3B9ACA07
               	movq	$0x7735940e, 0x10(%rax) # imm = 0x7735940E
               	movl	$0xb2d05e15, %ecx       # imm = 0xB2D05E15
               	movq	%rcx, 0x18(%rax)
               	movl	$0xee6b281c, %ecx       # imm = 0xEE6B281C
               	movq	%rcx, 0x20(%rax)
               	movabsq	$0x12a05f223, %rcx      # imm = 0x12A05F223
               	movq	%rcx, 0x28(%rax)
               	movabsq	$0x165a0bc2a, %rcx      # imm = 0x165A0BC2A
               	movq	%rcx, 0x30(%rax)
               	leaq	<rip>, %rax      # <addr>
               	movabsq	$0x1a13b8631, %rcx      # imm = 0x1A13B8631
               	movq	%rcx, 0x38(%rax)
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx      # <addr>
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	incq	%rax
               	movl	%eax, (%rsi)
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, 0x8(%rsi)
               	cmpl	$0x18, %eax
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	callq	<addr>
               	xorl	%esi, %esi
               	xorl	%r9d, %r9d
               	xorl	%eax, %eax
               	movq	%rsi, %rcx
               	testl	%ecx, %ecx
               	jle	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %r8
               	subq	%r8, %rcx
               	movl	(%rdi,%rcx,4), %ecx
               	addq	%rcx, %rax
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	movslq	%eax, %rax
               	addq	%rax, %r9
               	incq	%rsi
               	cmpl	$0x1f4, %esi            # imm = 0x1F4
               	jl	<addr>
               	cmpq	$0x7b0c, %r9            # imm = 0x7B0C
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%r9, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%r9d, %r9d
               	movq	%r9, %rsi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax,%rcx,8), %rdi
               	movabsq	$-0x768fa0ceed5d701b, %r8 # imm = 0x89705F3112A28FE5
               	movq	%rdi, %rax
               	imulq	%r8
               	leaq	(%rdx,%rdi), %rax
               	sarq	$0x1d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jle	<addr>
               	incq	%r9
               	cmpl	$0x3, %r9d
               	jl	<addr>
               	cmpq	$0x1e, %rsi
               	je	<addr>
               	leaq	<rip>, %rbx
               	xorl	%r9d, %r9d
               	movq	%r9, %rsi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax,%rcx,8), %rdi
               	movabsq	$-0x768fa0ceed5d701b, %r8 # imm = 0x89705F3112A28FE5
               	movq	%rdi, %rax
               	imulq	%r8
               	leaq	(%rdx,%rdi), %rax
               	sarq	$0x1d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jle	<addr>
               	incq	%r9
               	cmpl	$0x3, %r9d
               	jl	<addr>
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax      # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x12c, %rcx            # imm = 0x12C
               	je	<addr>
               	leaq	<rip>, %rsi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax      # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rdi
               	movq	%rcx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	movq	%rax, %rdx
               	movslq	(%rcx), %rsi
               	addq	%rsi, %rdx
               	movl	(%rcx), %esi
               	addq	$0x2, %rsi
               	movl	%esi, (%rcx)
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	cmpq	$0x26ac, %rdx           # imm = 0x26AC
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0x3f804000, (%rcx)     # imm = 0x3F804000
               	movss	(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x41804000, %eax       # imm = 0x41804000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movss	0x3c(%rax), %xmm0
               	movl	$0x3f804000, %eax       # imm = 0x3F804000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0x3f804000, (%rcx)     # imm = 0x3F804000
               	movss	(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %rax      # <addr>
               	movss	0x3c(%rax), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rsi, %rdi
               	movb	$0x2, %al
               	callq	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
