
object_macro_to_fn_macro_rescan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40032a <.text+0x8a>
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
               	callq	0x400567 <printf>
               	movslq	%eax, %rax
               	xorl	%eax, %eax
               	callq	0x40056d <abort>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
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
               	jne	0x400373 <.text+0xd3>
               	xorq	%r9, %r9
               	movq	%r9, %r8
               	andq	$0xff, %r8
               	movq	%r8, -0x28(%rbp)
               	jmp	0x40039e <.text+0xfe>
               	leaq	0xfd8e(%rip), %r12      # 0x410108
               	leaq	0xfd8e(%rip), %r14      # 0x41010f
               	movl	$0x13, %r15d
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movq	%rax, -0x28(%rbp)
               	jmp	0x40039e <.text+0xfe>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x8, %rbx
               	jne	0x4003d1 <.text+0x131>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	0x4003fb <.text+0x15b>
               	leaq	0xfd86(%rip), %r12      # 0x41015e
               	leaq	0xfd8a(%rip), %r14      # 0x410169
               	movl	$0x14, %ebx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movq	%rax, -0x30(%rbp)
               	jmp	0x4003fb <.text+0x15b>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
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
