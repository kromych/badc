
struct_linked_list.x64:	file format elf64-x86-64

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
               	xorq	%r11, %r11
               	movq	%r11, -0x8(%rbp)
               	movl	%r11d, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x20(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	movl	$0x10, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rbx
               	movslq	-0x20(%rbp), %rax
               	movl	%eax, (%rbx)
               	movq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r9)
               	movq	-0x10(%rbp), %rbx
               	movq	%rbx, -0x8(%rbp)
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x18(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	-0x18(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	%r9, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, -0x18(%rbp)
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
