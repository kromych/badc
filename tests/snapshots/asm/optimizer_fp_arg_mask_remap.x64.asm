
optimizer_fp_arg_mask_remap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movabsq	$0x3fe0000000000000, %rbx # imm = 0x3FE0000000000000
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %r12
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %r14
               	movabsq	$0x4010000000000000, %r15 # imm = 0x4010000000000000
               	movq	%r15, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rbx
               	xorq	%r15, %r15
               	movq	%r15, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x3fdea7ef9db22d0e, %r15 # imm = 0x3FDEA7EF9DB22D0E
               	movq	%r12, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%dl
               	movzbq	%dl, %rdx
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rdx
               	movq	%rdx, -0x38(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$0x3fdeb851eb851eb8, %r15 # imm = 0x3FDEB851EB851EB8
               	movq	%r12, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x38(%rbp)
               	jmp	<addr>
               	movq	-0x38(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3fec10624dd2f1aa, %r12 # imm = 0x3FEC10624DD2F1AA
               	movq	%r14, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r15b
               	movzbq	%r15b, %r15
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r15
               	movq	%r15, -0x40(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movabsq	$0x3fec189374bc6a7f, %r12 # imm = 0x3FEC189374BC6A7F
               	movq	%r14, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x40(%rbp)
               	jmp	<addr>
               	movq	-0x40(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r14 # imm = 0x4000000000000000
               	movq	%rbx, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3feff7ced916872b, %rbx # imm = 0x3FEFF7CED916872B
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r14b
               	movzbq	%r14b, %r14
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r14
               	movq	%r14, -0x48(%rbp)
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movabsq	$0x3ff004189374bc6a, %rbx # imm = 0x3FF004189374BC6A
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x13, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
