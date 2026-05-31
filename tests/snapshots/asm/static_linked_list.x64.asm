
static_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %r11
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	addq	$0x8, %r11
               	leaq	<rip>, %r8
               	movq	%r8, (%r11)
               	movl	$0x2, %r9d
               	movl	%r9d, (%r8)
               	addq	$0x8, %r8
               	leaq	<rip>, %r11
               	movq	%r11, (%r8)
               	movl	$0x3, %r9d
               	movl	%r9d, (%r11)
               	addq	$0x8, %r11
               	xorq	%r8, %r8
               	movq	%r8, (%r11)
               	movl	%r8d, -0x8(%rbp)
               	leaq	<rip>, %r9
               	movq	(%r9), %r8
               	movq	%r8, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movslq	-0x8(%rbp), %r9
               	movq	-0x10(%rbp), %r8
               	movslq	(%r8), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x8(%rbp)
               	addq	$0x8, %r8
               	movq	(%r8), %r11
               	movq	%r11, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0x6, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
