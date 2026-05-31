
for_loop_call_body_and_step.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002eb <.text+0xcb>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %rax
               	retq
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x40027d <.text+0x5d>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x7, %r11
               	jge	0x4002c2 <.text+0xa2>
               	jmp	0x4002ab <.text+0x8b>
               	movslq	-0x10(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x400248 <.text+0x28>
               	movq	%rax, %r9
               	movl	%r9d, -0x10(%rbp)
               	jmp	0x40027d <.text+0x5d>
               	movslq	-0x8(%rbp), %r12
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rbx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x400293 <.text+0x73>
               	movslq	-0x8(%rbp), %rbx
               	movl	$0x6, %r12d
               	imulq	%rbx, %r12
               	movslq	%r12d, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	0x400259 <.text+0x39>
               	addb	%al, (%rax)
