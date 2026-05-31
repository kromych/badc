
queens.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400454 <.text+0x234>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movslq	%edx, %r8
               	xorq	%rdi, %rdi
               	movl	%edi, -0x8(%rbp)
               	jmp	0x400256 <.text+0x36>
               	movslq	-0x8(%rbp), %rdi
               	cmpq	%r9, %rdi
               	jge	0x4002bd <.text+0x9d>
               	jmp	0x40027e <.text+0x5e>
               	movslq	-0x8(%rbp), %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x8(%rbp)
               	jmp	0x400256 <.text+0x36>
               	movslq	-0x8(%rbp), %rsi
               	movq	%r9, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	shlq	$0x2, %rsi
               	movq	%r11, %rdx
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rsi
               	movq	%r8, %rdx
               	subq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	jge	0x4002e6 <.text+0xc6>
               	jmp	0x4002cc <.text+0xac>
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %rdx
               	movabsq	$-0x1, %r10
               	imulq	%r10, %rdx
               	movl	%edx, -0x18(%rbp)
               	jmp	0x4002e6 <.text+0xc6>
               	movslq	-0x8(%rbp), %rdx
               	shlq	$0x2, %rdx
               	movq	%r11, %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rdx
               	cmpq	%r8, %rdx
               	jne	0x40030e <.text+0xee>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rdx
               	movslq	-0x18(%rbp), %rax
               	cmpq	%rax, %rdx
               	jne	0x40032d <.text+0x10d>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400268 <.text+0x48>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	cmpq	$0x8, %r12
               	jne	0x40038a <.text+0x16a>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x40039a <.text+0x17a>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x8, %r8
               	jge	0x4003ea <.text+0x1ca>
               	jmp	0x4003c6 <.text+0x1a6>
               	movslq	-0x10(%rbp), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	jmp	0x40039a <.text+0x17a>
               	movslq	-0x10(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	je	0x400415 <.text+0x1f5>
               	jmp	0x400410 <.text+0x1f0>
               	movslq	-0x8(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4003b0 <.text+0x190>
               	movq	%r12, %r14
               	shlq	$0x2, %r14
               	movq	%rbx, %rax
               	addq	%r14, %rax
               	movslq	-0x10(%rbp), %r14
               	movl	%r14d, (%rax)
               	movslq	-0x8(%rbp), %r15
               	movq	%r12, %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	0x400332 <.text+0x112>
               	addq	%rax, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x4003b0 <.text+0x190>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x20(%rbp), %rbx
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400332 <.text+0x112>
               	movslq	%eax, %rax
               	cmpq	$0x5c, %rax
               	je	0x4004a8 <.text+0x288>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
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
