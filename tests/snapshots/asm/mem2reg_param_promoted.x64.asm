
mem2reg_param_promoted.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002c7 <.text+0xa7>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	cmpq	$0x2, %rbx
               	jge	0x40027d <.text+0x5d>
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %r8
               	subq	$0x1, %r8
               	movslq	%r8d, %r12
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r14
               	subq	$0x2, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	addq	%rax, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	je	0x400310 <.text+0xf0>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1, %rax
               	je	0x400349 <.text+0x129>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1, %rax
               	je	0x400380 <.text+0x160>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x37, %rax
               	je	0x4003b9 <.text+0x199>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1a6d, %rax           # imm = 0x1A6D
               	je	0x4003f0 <.text+0x1d0>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
