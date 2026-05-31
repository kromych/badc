
sys_addr_zero_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002b7 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	0xfe16(%rip), %r11      # 0x4100e8
               	movq	(%r11), %rbx
               	movq	%rbx, %r11
               	callq	*%r11
               	movq	%rax, %r11
               	movslq	%r11d, %rbx
               	cmpq	$0x0, %rbx
               	jg	0x40030b <.text+0x6b>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfdde(%rip), %r11      # 0x4100f0
               	movq	(%r11), %r12
               	movq	%r12, %r11
               	callq	*%r11
               	movq	%rax, %r11
               	movl	$0x2a, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	callq	0x4004a7 <geteuid>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	movq	%r11, %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	callq	0x4004ad <getpid>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	movq	%r11, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
