
struct_by_value_param.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40032f <.text+0x10f>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %r11
               	movq	0x10(%rbp), %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r8
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	leaq	-0x8(%rbp), %r8
               	movabsq	$-0x1, %r9
               	movl	%r9d, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movl	%r9d, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r8
               	cmpq	$-0x1, %r8
               	je	0x4002d9 <.text+0xb9>
               	movabsq	$-0x1, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdi
               	cmpq	$-0x1, %rdi
               	je	0x400318 <.text+0xf8>
               	movabsq	$-0x2, %rdi
               	movq	%rdi, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %r11
               	movl	$0x3, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x4, %r9
               	movl	$0x7, %r8d
               	movl	%r8d, (%r9)
               	leaq	-0x8(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r8
               	movslq	%r8d, %rbx
               	cmpq	$0xa, %rbx
               	je	0x400399 <.text+0x179>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %rbx
               	cmpq	$0x3, %rbx
               	je	0x4003c5 <.text+0x1a5>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %r8
               	cmpq	$0x7, %r8
               	je	0x4003fc <.text+0x1dc>
               	movl	$0x3, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
