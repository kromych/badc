
switch_label_after_terminator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002e6 <.text+0xc6>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x4002a0 <.text+0x80>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x4002cc <.text+0xac>
               	movl	$0x2, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x4002cc <.text+0xac>
               	movl	$0x3, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x4002cc <.text+0xac>
               	movabsq	$-0x1, %r9
               	movq	%r9, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x1, %r11
               	je	0x40025d <.text+0x3d>
               	cmpq	$0x2, %r11
               	je	0x40026c <.text+0x4c>
               	cmpq	$0x3, %r11
               	je	0x40027b <.text+0x5b>
               	jmp	0x40028a <.text+0x6a>
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x64, %r8
               	movslq	%r8d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	cmpq	$0x65, %r9
               	je	0x400335 <.text+0x115>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	cmpq	$0x66, %r9
               	je	0x400371 <.text+0x151>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	cmpq	$0x67, %r9
               	je	0x4003ac <.text+0x18c>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	cmpq	$-0x1, %r9
               	je	0x4003e8 <.text+0x1c8>
               	movl	$0x4, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
