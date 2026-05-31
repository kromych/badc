
struct_value_basics.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	movl	$0x3, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x4, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	cmpq	$0x3, %r9
               	je	0x400285 <.text+0x65>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x4, %rax
               	je	0x4002b2 <.text+0x92>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r9
               	cmpq	$0x3, %r9
               	je	0x4002d8 <.text+0xb8>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r8
               	cmpq	$0x4, %r8
               	je	0x400304 <.text+0xe4>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %r8d
               	movl	%r8d, (%rax)
               	addq	$0x4, %rax
               	movl	$0x28, %r9d
               	movl	%r9d, (%rax)
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	cmpq	$0x1e, %r9
               	je	0x40033f <.text+0x11f>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x28, %rax
               	je	0x40036c <.text+0x14c>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x64, %r9d
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0xc8, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r9
               	cmpq	$0x1e, %r9
               	je	0x4003af <.text+0x18f>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rax
               	cmpq	$0x64, %rax
               	je	0x4003d5 <.text+0x1b5>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r9
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %rax
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x172, %r9             # imm = 0x172
               	je	0x40042f <.text+0x20f>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
