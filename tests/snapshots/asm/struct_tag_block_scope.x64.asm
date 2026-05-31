
struct_tag_block_scope.x64:	file format elf64-x86-64

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
               	movl	$0x2, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movl	$0x5, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	cmpq	$0x5, %r9
               	je	0x40027e <.text+0x5e>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	movl	$0x3, %eax
               	movl	%eax, (%r9)
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %rax
               	cmpq	$0x2, %rax
               	je	0x4002b0 <.text+0x90>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %r8
               	cmpq	$0x3, %r8
               	je	0x4002d2 <.text+0xb2>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
