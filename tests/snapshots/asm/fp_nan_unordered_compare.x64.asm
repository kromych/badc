
fp_nan_unordered_compare.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movq	%r11, %xmm7
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm7
               	movq	%xmm7, %r10
               	movq	%r10, -0x10(%rbp)
               	movabsq	$0x4014000000000000, %r9 # imm = 0x4014000000000000
               	movabsq	$0x3ff0000000000000, %r8 # imm = 0x3FF0000000000000
               	movq	%r8, %xmm7
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x20(%rbp)
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	xorq	%r8, %r8
               	movq	%rax, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xa, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xb, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	xorq	%rax, %rax
               	movq	%r8, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x18, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1a, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4018000000000000, %r8 # imm = 0x4018000000000000
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x28, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movl	$0x29, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movl	$0x2a, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r8
               	movabsq	$0x7e37e43c8800759c, %rax # imm = 0x7E37E43C8800759C
               	movq	%r8, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movl	$0x2b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x2c, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
