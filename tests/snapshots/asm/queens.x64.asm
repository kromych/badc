
queens.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400463 <.text+0x243>
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
               	jge	0x4002c3 <.text+0xa3>
               	jmp	0x400281 <.text+0x61>
               	movslq	-0x8(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x8(%rbp)
               	jmp	0x400256 <.text+0x36>
               	movslq	-0x8(%rbp), %rsi
               	movq	%r9, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	movq	%r11, %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rdx
               	movq	%r8, %rsi
               	subq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jge	0x4002ec <.text+0xcc>
               	jmp	0x4002d2 <.text+0xb2>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %rdx
               	movabsq	$-0x1, %rsi
               	imulq	%rdx, %rsi
               	movl	%esi, -0x18(%rbp)
               	jmp	0x4002ec <.text+0xcc>
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	movq	%r11, %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rdx
               	cmpq	%r8, %rdx
               	jne	0x400317 <.text+0xf7>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rsi
               	movslq	-0x18(%rbp), %rax
               	cmpq	%rax, %rsi
               	jne	0x400336 <.text+0x116>
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
               	jne	0x400393 <.text+0x173>
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
               	jmp	0x4003a3 <.text+0x183>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x8, %r8
               	jge	0x4003f6 <.text+0x1d6>
               	jmp	0x4003d2 <.text+0x1b2>
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	jmp	0x4003a3 <.text+0x183>
               	movslq	-0x10(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	je	0x400421 <.text+0x201>
               	jmp	0x40041c <.text+0x1fc>
               	movslq	-0x8(%rbp), %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4003b9 <.text+0x199>
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
               	callq	0x40033b <.text+0x11b>
               	movq	%r15, %r14
               	addq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	jmp	0x4003b9 <.text+0x199>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x20(%rbp), %rbx
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x40033b <.text+0x11b>
               	movslq	%eax, %r12
               	cmpq	$0x5c, %r12
               	je	0x4004b7 <.text+0x297>
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
               	addb	%al, 0x41(%rdx)
