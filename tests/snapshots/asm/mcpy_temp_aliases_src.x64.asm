
mcpy_temp_aliases_src.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%r12, (%rsp)
               	movq	%r14, 0x8(%rsp)
               	movq	%r15, 0x10(%rsp)
               	movl	$0x1, %r11d
               	movl	$0x2, %r9d
               	movl	$0x3, %r8d
               	movl	$0x4, %edi
               	movl	$0x5, %esi
               	movl	$0x6, %edx
               	movl	$0x7, %ecx
               	movl	$0x8, %eax
               	movl	$0x9, %r15d
               	movl	$0xa, %r14d
               	movslq	%r11d, %r11
               	movslq	%r9d, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	movslq	%r8d, %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movslq	%edi, %rdi
               	addq	%rdi, %r11
               	movslq	%r11d, %r11
               	movslq	%esi, %rsi
               	addq	%rsi, %r11
               	movslq	%r11d, %r11
               	movslq	%edx, %rdx
               	addq	%rdx, %r11
               	movslq	%r11d, %r11
               	movslq	%ecx, %rcx
               	addq	%rcx, %r11
               	movslq	%r11d, %r11
               	movslq	%eax, %rax
               	addq	%rax, %r11
               	movslq	%r11d, %r11
               	movslq	%r15d, %r15
               	addq	%r15, %r11
               	movslq	%r11d, %r11
               	movslq	%r14d, %r14
               	addq	%r14, %r11
               	movslq	%r11d, %r11
               	leaq	-0x20(%rbp), %r14
               	leaq	0xfdea(%rip), %r15      # 0x4100d0
               	pushq	%rax
               	movq	(%r15), %rax
               	movq	%rax, (%r14)
               	movq	0x8(%r15), %rax
               	movq	%rax, 0x8(%r14)
               	movq	0x10(%r15), %rax
               	movq	%rax, 0x10(%r14)
               	movq	0x18(%r15), %rax
               	movq	%rax, 0x18(%r14)
               	popq	%rax
               	movq	%r14, %rax
               	movslq	%r11d, %r11
               	cmpq	$0x37, %r11
               	je	0x40033b <.text+0x11b>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	movq	(%r11), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	je	0x400372 <.text+0x152>
               	movl	$0x2, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r11
               	cmpq	$0x2222, %r11           # imm = 0x2222
               	je	0x4003af <.text+0x18f>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	addq	$0x10, %r11
               	movq	(%r11), %rax
               	cmpq	$0x3333, %rax           # imm = 0x3333
               	je	0x4003ed <.text+0x1cd>
               	movl	$0x4, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r11
               	cmpq	$0x4444, %r11           # imm = 0x4444
               	je	0x40042a <.text+0x20a>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
