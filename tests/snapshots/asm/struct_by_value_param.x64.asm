
struct_by_value_param.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400323 <.text+0x103>
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
               	addq	$0x4, %r8
               	movslq	(%r8), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	leaq	-0x8(%rbp), %r11
               	movabsq	$-0x1, %r8
               	movl	%r8d, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	addq	$0x4, %rdi
               	movl	%r8d, (%rdi)
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %rdi
               	cmpq	$-0x1, %rdi
               	je	0x4002d0 <.text+0xb0>
               	movabsq	$-0x1, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x8(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$-0x1, %rax
               	je	0x40030c <.text+0xec>
               	movabsq	$-0x2, %rdi
               	movq	%rdi, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movslq	%r9d, %rax
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
               	addq	$0x4, %r8
               	movl	$0x7, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x8(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	je	0x400387 <.text+0x167>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x3, %rbx
               	je	0x4003b3 <.text+0x193>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x7, %rax
               	je	0x4003e6 <.text+0x1c6>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
