
setjmp_longjmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40030d <.text+0x6d>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	movq	%rbx, %r8
               	addq	$0x200, %r8             # imm = 0x200
               	movl	%r12d, (%r8)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4005f7 <longjmp>
               	movzbq	%al, %rax
               	movq	%rax, %rdi
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x250, %rsp            # imm = 0x250
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400363 <.text+0xc3>
               	movl	$0xb, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	leaq	-0x208(%rbp), %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4005fd <setjmp>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movslq	%r14d, %r12
               	cmpq	$0x0, %r12
               	jne	0x4003d2 <.text+0x132>
               	movslq	%ebx, %r12
               	leaq	-0x208(%rbp), %r15
               	movl	$0x7, %r12d
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movq	%rax, %rsi
               	movl	$0xc, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movslq	%r14d, %r12
               	cmpq	$0x7, %r12
               	je	0x40040a <.text+0x16a>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movslq	%ebx, %rsi
               	cmpq	$0x1, %rsi
               	je	0x400441 <.text+0x1a1>
               	movl	$0xe, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %r12
               	movq	%r12, %rsi
               	addq	$0x200, %rsi            # imm = 0x200
               	movslq	(%rsi), %r12
               	cmpq	$0x7, %r12
               	je	0x40048a <.text+0x1ea>
               	movl	$0xf, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
