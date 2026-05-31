
multi_declarator_prototypes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400249 <.text+0x29>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %rax
               	retq
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	shlq	$0x1, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	0xfe6c(%rip), %r11      # 0x4100d0
               	movl	$0xa, %r9d
               	movl	%r9d, (%r11)
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	cmpq	$0x3, %r9
               	je	0x4002a8 <.text+0x88>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r12d
               	movq	%r12, %rdi
               	callq	0x40023b <.text+0x1b>
               	movq	%rax, %r9
               	cmpq	$0x6, %r9
               	je	0x4002e4 <.text+0xc4>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfde5(%rip), %r12      # 0x4100d0
               	movslq	(%r12), %r9
               	cmpq	$0xa, %r9
               	je	0x40031a <.text+0xfa>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
