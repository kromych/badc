
two_d_float_array_partial_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0xc, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	addq	$0x1, %rbx
               	jmp	<addr>
               	xorq	%r12, %r12
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x18(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movslq	%r12d, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r12d, %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%ebx, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movslq	%r12d, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movss	(%rax,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movss	(%rax,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movslq	%ebx, %rdx
               	movslq	%r12d, %rcx
               	leaq	<rip>, %rax
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	%r8, %rax
               	movq	%rcx, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movss	(%rax,%riz), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0xc, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	movss	(%rdx,%riz), %xmm1
               	movq	%rdx, %rsi
               	addq	$0x4, %rsi
               	movss	(%rsi,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addq	$0x8, %rdx
               	movss	(%rdx,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movss	-0x18(%rbp,%riz), %xmm0
               	xorq	%rax, %rax
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movss	-0x18(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
