
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
               	movq	%r8, %r9
               	addq	$0x4, %r9
               	movl	$0x4, %r8d
               	movl	%r8d, (%r9)
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	cmpq	$0x3, %r8
               	je	0x400288 <.text+0x68>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x4, %r11
               	je	0x4002b8 <.text+0x98>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x3, %r11
               	je	0x4002de <.text+0xbe>
               	movl	$0x3, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r11
               	cmpq	$0x4, %r11
               	je	0x40030a <.text+0xea>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %r9d
               	movl	%r9d, (%rax)
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movl	$0x28, %eax
               	movl	%eax, (%r11)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %rax
               	cmpq	$0x1e, %rax
               	je	0x400347 <.text+0x127>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x28, %r9
               	je	0x400377 <.text+0x157>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x64, %r9d
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movl	$0xc8, %r11d
               	movl	%r11d, (%r9)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x1e, %r11
               	je	0x4003c1 <.text+0x1a1>
               	movl	$0x7, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x64, %r11
               	je	0x4003e7 <.text+0x1c7>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r11
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	movq	%r11, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r11
               	movq	%r9, %rax
               	addq	%r11, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r11
               	movq	%rax, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r11
               	cmpq	$0x172, %r11            # imm = 0x172
               	je	0x400450 <.text+0x230>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
