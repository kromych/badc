
for_loop_call_body_and_step.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002de <.text+0xbe>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x400277 <.text+0x57>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x7, %r11
               	jge	0x4002b5 <.text+0x95>
               	jmp	0x4002a1 <.text+0x81>
               	movslq	-0x10(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x400245 <.text+0x25>
               	movl	%eax, -0x10(%rbp)
               	jmp	0x400277 <.text+0x57>
               	movslq	-0x8(%rbp), %r12
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	movl	%eax, -0x8(%rbp)
               	jmp	0x40028d <.text+0x6d>
               	movslq	-0x8(%rbp), %rax
               	movl	$0x6, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	0x400253 <.text+0x33>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
