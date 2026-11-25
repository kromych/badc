
byte_reversal_by_shifts.x64:	file format elf64-x86-64

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

<staged64>:
               	movq	%rdi, %rax
               	bswapq	%rax
               	retq

<terms64>:
               	movq	%rdi, %rax
               	bswapq	%rax
               	retq

<masks32>:
               	movl	%edi, %eax
               	bswapl	%eax
               	retq

<shifts32>:
               	movl	%edi, %eax
               	bswapl	%eax
               	retq

<signed32>:
               	movl	%edi, %eax
               	bswapl	%eax
               	retq

<pair16>:
               	movzwl	%di, %eax
               	rolw	$0x8, %ax
               	retq

<sum16>:
               	movzwl	%di, %eax
               	rolw	$0x8, %ax
               	retq

<halves32>:
               	movq	%rdi, %rax
               	andq	$0xff00ff, %rax         # imm = 0xFF00FF
               	shlq	$0x8, %rax
               	movl	$0xff00ff00, %ecx       # imm = 0xFF00FF00
               	andq	%rdi, %rcx
               	shrq	$0x8, %rcx
               	orq	%rcx, %rax
               	retq

<rotate64>:
               	rorq	$0x8, %rdi
               	movq	%rdi, %rax
               	retq

<widened32>:
               	movl	%edi, %eax
               	bswapl	%eax
               	movslq	%eax, %rax
               	retq

<main>:
               	subq	$0x50, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movabsq	$0x123456789abcdef, %rbx # imm = 0x123456789ABCDEF
               	xorl	%r13d, %r13d
               	movq	%rbx, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rbx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x20(%rsp,%rdx)
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	xorl	%edx, %edx
               	shlq	$0x8, %rcx
               	movzbq	0x20(%rsp,%rdx), %rsi
               	orq	%rsi, %rcx
               	incq	%rdx
               	nop
               	cmpl	$0x8, %edx
               	jl	<addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rbx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x28(%rsp,%rdx)
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	xorl	%edx, %edx
               	shlq	$0x8, %rcx
               	movzbq	0x28(%rsp,%rdx), %rsi
               	orq	%rsi, %rcx
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	nop
               	callq	<addr>
               	movl	%eax, %r8d
               	movl	%ebx, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x30(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	shlq	$0x8, %rax
               	movzbq	0x30(%rsp,%rcx), %rdx
               	orq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, %r8d
               	movl	%ebx, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x38(%rsp,%rcx)
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	shlq	$0x8, %rax
               	movzbq	0x38(%rsp,%rcx), %rdx
               	orq	%rdx, %rax
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, %r8d
               	movl	%ebx, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x40(%rsp,%rcx)
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	shlq	$0x8, %rax
               	movzbq	0x40(%rsp,%rcx), %rdx
               	orq	%rdx, %rax
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %r12, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x48(%rsp,%rdx)
               	incq	%rdx
               	nopl	(%rax)
               	cmpl	$0x2, %edx
               	jl	<addr>
               	xorl	%edx, %edx
               	shlq	$0x8, %rcx
               	movzbq	0x48(%rsp,%rdx), %rsi
               	orq	%rsi, %rcx
               	incq	%rdx
               	nopw	(%rax,%rax)
               	cmpl	$0x2, %edx
               	jl	<addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %r12, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x50(%rsp,%rdx)
               	incq	%rdx
               	nopl	(%rax)
               	cmpl	$0x2, %edx
               	jl	<addr>
               	xorl	%edx, %edx
               	shlq	$0x8, %rcx
               	movzbq	0x50(%rsp,%rdx), %rsi
               	orq	%rsi, %rcx
               	incq	%rdx
               	nopw	(%rax,%rax)
               	cmpl	$0x2, %edx
               	jl	<addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%ebx, %ecx
               	movzwl	%bx, %esi
               	rolw	$0x8, %si
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x18, %rdx
               	orq	%rdx, %rsi
               	shrq	$0x18, %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rsi
               	nop
               	cmpl	%esi, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	rorxq	$0x8, %rbx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%ebx, %edi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x58(%rsp,%rdx)
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	xorl	%edx, %edx
               	shlq	$0x8, %rcx
               	movzbq	0x58(%rsp,%rdx), %rsi
               	orq	%rsi, %rcx
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movabsq	$0x5851f42d4c957f2d, %rax # imm = 0x5851F42D4C957F2D
               	imulq	%rbx, %rax
               	movabsq	$0x14057b7ef767814f, %rbx # imm = 0x14057B7EF767814F
               	addq	%rax, %rbx
               	movq	%rbx, %rax
               	shrq	$0x1d, %rax
               	xorq	%rax, %rbx
               	incq	%r13
               	nopw	%cs:(%rax,%rax)
               	cmpl	$0x1000, %r13d          # imm = 0x1000
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x50, %rsp
               	retq
