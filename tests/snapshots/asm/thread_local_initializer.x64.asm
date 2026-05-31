
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
               	movq	%fs:0x0, %r9
               	subq	$0x10, %r9
               	movslq	(%r9), %rax
               	cmpq	$-0x3, %rax
               	je	0x4002dd <.text+0x6d>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	subq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x0, %r9
               	je	0x400304 <.text+0x94>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r9
               	subq	$0x18, %r9
               	movq	%fs:0x0, %rax
               	subq	$0x18, %rax
               	movslq	(%rax), %r8
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movslq	(%rax), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r9)
               	movq	%fs:0x0, %rdi
               	subq	$0x18, %rdi
               	movslq	(%rdi), %r8
               	cmpq	$0x4, %r8
               	je	0x40036a <.text+0xfa>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
