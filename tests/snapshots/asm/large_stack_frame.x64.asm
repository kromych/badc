
large_stack_frame.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40026e <.text+0x3e>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	movslq	%edi, %r11
               	movslq	%r11d, %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x28, %ebx
               	movq	%rbx, %rdi
               	callq	0x400247 <.text+0x17>
               	movslq	%eax, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
