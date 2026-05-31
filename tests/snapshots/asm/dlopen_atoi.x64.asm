
dlopen_atoi.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfde1(%rip)           # 0x4100f8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x2, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400567 <dlopen>
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	jne	0x400382 <.text+0x82>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd87(%rip), %r15      # 0x410110
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40056d <dlsym>
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x4003dd <.text+0xdd>
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x400573 <dlclose>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd31(%rip), %rbx      # 0x410115
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %r15
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x400573 <dlclose>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movslq	%r15d, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
