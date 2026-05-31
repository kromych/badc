
recursion_factorial.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002b3 <.text+0x93>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	cmpq	$0x2, %rbx
               	jge	0x400279 <.text+0x59>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %r9
               	subq	$0x1, %r9
               	movslq	%r9d, %r12
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r8
               	movq	%rbx, %r12
               	imulq	%r8, %r12
               	movslq	%r12d, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x5, %ebx
               	movq	%rbx, %rdi
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	0x400237 <.text+0x17>
