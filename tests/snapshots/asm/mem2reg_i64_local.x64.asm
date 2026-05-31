
mem2reg_i64_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002a2 <.text+0x82>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %r11
               	movl	$0x3, %r9d
               	imulq	%r11, %r9
               	xorq	%r11, %r11
               	movq	%r11, -0x10(%rbp)
               	movq	%r11, -0x18(%rbp)
               	jmp	0x40025f <.text+0x3f>
               	movq	-0x18(%rbp), %r11
               	cmpq	$0x4, %r11
               	jge	0x400295 <.text+0x75>
               	movq	-0x10(%rbp), %r11
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movq	%r8, -0x10(%rbp)
               	movq	-0x18(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movq	%r8, -0x18(%rbp)
               	jmp	0x40025f <.text+0x3f>
               	movq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x7, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
