
pointer_arithmetic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x8, %r11d
               	movslq	%r11d, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400427 <malloc>
               	movl	$0x1, %ebx
               	movl	%ebx, (%rax)
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movl	$0x2, %ebx
               	movl	%ebx, (%r8)
               	movslq	(%rax), %rdi
               	addq	$0x4, %rax
               	movslq	(%rax), %rbx
               	addq	%rbx, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
