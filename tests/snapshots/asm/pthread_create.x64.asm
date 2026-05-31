
pthread_create.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002d0 <.text+0x20>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100e0
               	movq	%rdi, %r11
               	movl	$0xb, %eax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x2, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4004d7 <dlopen>
               	movq	%rax, %r14
               	leaq	0xfdea(%rip), %r15      # 0x4100f8
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4004dd <dlsym>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xfddd(%rip), %r15      # 0x410107
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4004dd <dlsym>
               	movq	%rax, %r12
               	leaq	-0x20(%rbp), %r14
               	leaq	-0x7e(%rip), %r15       # 0x4002c7 <.text+0x17>
               	movq	0x28(%rsp), %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	*%r11
               	movq	%rax, %rsi
               	movq	-0x20(%rbp), %rbx
               	leaq	-0x28(%rbp), %r14
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %r15
               	movq	-0x28(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
