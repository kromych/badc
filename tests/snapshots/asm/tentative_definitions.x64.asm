
tentative_definitions.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfe92(%rip), %r11      # 0x4100d0
               	movslq	(%r11), %r9
               	cmpq	$0x3, %r9
               	je	0x400254 <.text+0x34>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfe7d(%rip), %r9       # 0x4100d8
               	movslq	(%r9), %rax
               	movq	%r9, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	$0x8, %r9
               	movslq	(%r9), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	0x400297 <.text+0x77>
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	retq
               	xorq	%rax, %rax
               	retq
