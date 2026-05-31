
thread_local_initializer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe49(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %r11
               	subq	$0x18, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x7, %r9
               	je	0x4002b2 <.text+0x42>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r11
               	subq	$0x10, %r11
               	movslq	(%r11), %rax
               	cmpq	$-0x3, %rax
               	je	0x4002d9 <.text+0x69>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r11
               	subq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	0x400300 <.text+0x90>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r11
               	subq	$0x18, %r11
               	movq	%fs:0x0, %rax
               	subq	$0x18, %rax
               	movslq	(%rax), %r8
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movslq	(%rax), %rdi
               	movq	%r8, %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%r11)
               	movq	%fs:0x0, %rdi
               	subq	$0x18, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x4, %rax
               	je	0x400369 <.text+0xf9>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
