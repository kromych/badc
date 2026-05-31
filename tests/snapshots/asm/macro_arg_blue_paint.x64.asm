
macro_arg_blue_paint.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40026f <.text+0x4f>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r9, (%r11)
               	xorq	%rax, %rax
               	retq
               	movq	%rdi, %r11
               	movq	(%r11), %r9
               	movslq	(%r9), %rax
               	retq
               	movq	%rdi, %r11
               	movq	(%r11), %r9
               	movslq	(%r9), %rax
               	retq
               	movq	%rdi, %r11
               	movq	(%r11), %r9
               	movslq	(%r9), %r11
               	movq	%r11, %r9
               	addq	$0x7, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %r11
               	movl	$0x64, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %rbx
               	leaq	-0x8(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r11
               	leaq	-0x10(%rbp), %r14
               	movq	%r14, %rdi
               	callq	0x400244 <.text+0x24>
               	movq	%rax, %r12
               	cmpq	$0x64, %r12
               	je	0x4002f4 <.text+0xd4>
               	movl	$0xb, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r15
               	movq	%r15, %rdi
               	callq	0x40024e <.text+0x2e>
               	movq	%rax, %r12
               	cmpq	$0x64, %r12
               	je	0x400338 <.text+0x118>
               	movl	$0xc, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r14
               	movq	%r14, %rdi
               	callq	0x400258 <.text+0x38>
               	movq	%rax, %r12
               	cmpq	$0x6b, %r12
               	je	0x40037c <.text+0x15c>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
