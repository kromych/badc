
parenthesized_function_declarator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400260 <.text+0x40>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %rax
               	retq
               	movslq	%edi, %r11
               	leaq	0xfe7e(%rip), %rax      # 0x4100d0
               	movq	%r11, %r8
               	shlq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%rax)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0xa, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r12
               	movl	$0x5, %r14d
               	movq	%r14, %rdi
               	callq	0x400248 <.text+0x28>
               	movq	%rax, %r8
               	movslq	%r12d, %r14
               	cmpq	$0xb, %r14
               	je	0x4002cd <.text+0xad>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x0, %r8
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x20(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x400308 <.text+0xe8>
               	movslq	(%r8), %r14
               	cmpq	$0xa, %r14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x20(%rbp)
               	jmp	0x400308 <.text+0xe8>
               	movq	-0x20(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x40033c <.text+0x11c>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
