
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%r9d, %r9d
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x900000004, %rax      # imm = 0x900000004
               	movq	%rax, <rip> # <addr>
               	movl	$0x10, <rip> # <addr>
               	movl	$0x19, <rip> # <addr>
               	movabsq	$0x3100000024, %rax     # imm = 0x3100000024
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x5100000040, %rax     # imm = 0x5100000040
               	movq	%rax, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x3b9aca07, <rip> # imm = 0x3B9ACA07
                                                # <addr>
               	movq	$0x7735940e, <rip> # imm = 0x7735940E
                                                # <addr>
               	movl	$0xb2d05e15, %eax       # imm = 0xB2D05E15
               	movq	%rax, <rip> # <addr>
               	movl	$0xee6b281c, %eax       # imm = 0xEE6B281C
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x12a05f223, %rax      # imm = 0x12A05F223
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x165a0bc2a, %rax      # imm = 0x165A0BC2A
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x1a13b8631, %rax      # imm = 0x1A13B8631
               	movq	%rax, <rip> # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rcx, 0x8(%rdx)
               	cmpl	$0x18, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rcx, %rdx
               	incq	%rax
               	movl	%eax, (%rdx)
               	cmpl	$0x18, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rsi, %rcx
               	testl	%ecx, %ecx
               	jle	<addr>
               	leaq	<rip>, %rdi # <addr>
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
               	leave
               	retq
               	xorl	%r9d, %r9d
               	movq	%r9, %rsi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
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
               	leaq	<rip>, %r10
               	movq	%r10, 0x8(%rsp)
               	xorl	%r9d, %r9d
               	movq	%r9, %rsi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
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
               	movq	0x8(%rsp), %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
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
               	leaq	<rip>, %rax # <addr>
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
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	<rip>, %esi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movq	%rax, %rcx
               	movslq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	movl	<rip>, %edx # <addr>
               	addq	$0x2, %rdx
               	movl	%edx, <rip> # <addr>
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	cmpq	$0x26ac, %rcx           # imm = 0x26AC
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xc8, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	<rip>, %esi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	xorps	%xmm0, %xmm0
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0x3f804000, (%rcx)     # imm = 0x3F804000
               	movss	(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	xorps	%xmm0, %xmm0
               	leaq	<rip>, %rcx # <addr>
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
               	movss	<rip>, %xmm1 # <addr>
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rsi, %rdi
               	movb	$0x2, %al
               	callq	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
