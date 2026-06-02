
negative_float_in_array_init.x64:	file format elf64-x86-64

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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %r11
               	movq	(%r11), %r9
               	movabsq	$0x3ff8000000000000, %r8 # imm = 0x3FF8000000000000
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r9
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x10, %r9
               	movq	(%r9), %r9
               	movabsq	$0x421e449a94000000, %rax # imm = 0x421E449A94000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%r11), %r9
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movq	%r9, %xmm7
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	addq	$0x10, %r11
               	movq	(%r11), %r11
               	movq	%r11, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r11
               	movabsq	$0x421e449a94000000, %rax # imm = 0x421E449A94000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm7
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%r11, %xmm14
               	ucomisd	%xmm7, %xmm14
               	seta	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x10(%rbp)
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x421e449a94000000, %r11 # imm = 0x421E449A94000000
               	movq	%r11, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, %xmm15
               	subsd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
