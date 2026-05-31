
linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%r11, %r11
               	movq	%r11, -0x8(%rbp)
               	movl	%r11d, -0x20(%rbp)
               	movl	%r11d, -0x28(%rbp)
               	jmp	0x4002aa <.text+0x3a>
               	movslq	-0x28(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x400317 <.text+0xa7>
               	jmp	0x4002d6 <.text+0x66>
               	leaq	-0x28(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x4002aa <.text+0x3a>
               	movl	$0x10, %r11d
               	movslq	%r11d, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004b7 <malloc>
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movslq	-0x28(%rbp), %rax
               	movq	%rax, (%rbx)
               	movq	-0x18(%rbp), %r9
               	addq	$0x8, %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r9)
               	movq	-0x18(%rbp), %rbx
               	movq	%rbx, -0x8(%rbp)
               	jmp	0x4002c0 <.text+0x50>
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, -0x10(%rbp)
               	jmp	0x400324 <.text+0xb4>
               	movq	-0x10(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400359 <.text+0xe9>
               	movslq	-0x20(%rbp), %rax
               	movq	-0x10(%rbp), %rbx
               	movq	(%rbx), %r9
               	addq	%r9, %rax
               	movl	%eax, -0x20(%rbp)
               	addq	$0x8, %rbx
               	movq	(%rbx), %r9
               	movq	%r9, -0x10(%rbp)
               	jmp	0x400324 <.text+0xb4>
               	movslq	-0x20(%rbp), %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
