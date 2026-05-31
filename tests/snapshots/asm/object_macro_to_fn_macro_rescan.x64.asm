
object_macro_to_fn_macro_rescan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400330 <.text+0x90>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movslq	%edx, %r14
               	leaq	0xfdfb(%rip), %r15      # 0x4100e0
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x400577 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	0x40057d <abort>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x7, %ebx
               	movslq	%ebx, %r9
               	cmpq	$0x7, %r9
               	jne	0x400379 <.text+0xd9>
               	xorq	%r9, %r9
               	movq	%r9, %r8
               	andq	$0xff, %r8
               	movq	%r8, -0x28(%rbp)
               	jmp	0x4003a7 <.text+0x107>
               	leaq	0xfd88(%rip), %r12      # 0x410108
               	leaq	0xfd88(%rip), %r14      # 0x41010f
               	movl	$0x13, %r15d
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movq	%rax, %rsi
               	movq	%rsi, -0x28(%rbp)
               	jmp	0x4003a7 <.text+0x107>
               	movslq	%ebx, %rsi
               	movq	%rsi, %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x8, %rbx
               	jne	0x4003da <.text+0x13a>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, -0x30(%rbp)
               	jmp	0x400407 <.text+0x167>
               	leaq	0xfd7d(%rip), %r12      # 0x41015e
               	leaq	0xfd81(%rip), %r14      # 0x410169
               	movl	$0x14, %ebx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movq	%rax, %r15
               	movq	%r15, -0x30(%rbp)
               	jmp	0x400407 <.text+0x167>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
