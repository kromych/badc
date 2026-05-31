
unsigned_div_in_assign.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40028b <.text+0x6b>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movq	%rdi, %r11
               	movq	(%r11), %r9
               	movl	$0x18, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	(%r11), %r8
               	movl	$0x7, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	movslq	%edi, %r11
               	movl	$0x64, %edi
               	imulq	%r11, %rdi
               	movslq	%edi, %rdi
               	movslq	%r9d, %r11
               	movq	%rdi, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfe2b(%rip), %r9       # 0x4100d0
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x8(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	cmpq	$0x3ea, %r9             # imm = 0x3EA
               	jne	0x4002d8 <.text+0xb8>
               	xorq	%r9, %r9
               	movq	%r9, -0x18(%rbp)
               	jmp	0x4002e7 <.text+0xc7>
               	movl	$0x1, %r9d
               	movq	%r9, -0x18(%rbp)
               	jmp	0x4002e7 <.text+0xc7>
               	movq	-0x18(%rbp), %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
